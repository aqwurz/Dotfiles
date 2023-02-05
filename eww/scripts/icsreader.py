import os
import re
from datetime import datetime, timedelta
from pytz import timezone
from sys import argv

def timestamp_fix(t):
    """Changes an ics timestamp into a _date_- and human-readable variant.

    Args:
        t (str): The ics timestamp.

    Returns: 
        str: A YYYY-MM-DD HH:MM timestamp.

    """
    d = datetime.strptime(t, "%Y%m%dT%H%M%S%z")
    return d.astimezone(timezone('Europe/Berlin')).strftime("%Y-%m-%d %H:%M")

def read_ics(folder, name="personal"):
    """Reads .ics files and outputs their info in a text format.

    Args:
        folder (str): A path to a folder containing ics files.
        name (str): The name of the calendar. Defaults to "personal".

    Returns: 
        list: A list of dictionaries representing events.

    """
    events = []
    for fn in os.listdir(folder):
        if "ics" in fn:
            with open(os.path.join(folder, fn), 'r') as fr:
                event = {
                    'calendar': name, 
                    #'variable': name+str(len(events)),
                    'start': 'N/A',
                    'end': 'N/A', 
                    'location': 'No location',
                    'title': 'Empty event',
                    'description': 'Nothing to see here...',
                    'all-day': False
                }
                f = fr.readlines()
                i = 0
                while i < len(f):
                    l = f[i]
                    if 'DTSTART' in l:
                        event['start'] = timestamp_fix(l[8:-1])
                    elif 'DTEND' in l:
                        event['end'] = timestamp_fix(l[6:-1])
                    elif 'LOCATION' in l:
                        event['location'] = l[9:-1]
                    elif 'SUMMARY' in l:
                        event['title'] = l[8:-1]
                    elif 'DESCRIPTION' in l:
                        event['description'] = l[12:-1]
                        i+=1
                        while f[i][0:3] not in ["UID", "SUM", "LOC", "TIT", "URL"]:
                            event['description'] += f[i][1:-1]
                            i+=1
                        i-=1
                        event['description'] = re.sub(r'\\n',r'\n',event['description'])
                        event['description'] = re.sub(r'\\,',r',',event['description'])
                    i+=1
            events.append(event)
    return events

def read_evt(folder, name="personal"):
    """Reads .evt files and outputs their info in a text format.

    Args:
        folder (str): A path to a folder containing evt files.
        name (str): The name of the calendar. Defaults to "personal".

    Returns: 
        list: A list of dictionaries representing events.

    """
    events = []
    for fn in os.listdir(folder):
        if "evt" in fn:
            repeat_freq = 0
            repeat_until = ""
            no_repeat = []
            with open(os.path.join(folder, fn), 'r') as fr:
                event = {
                    'calendar': name, 
                    #'variable': name+str(len(events)),
                    'start': 'N/A',
                    'end': 'N/A', 
                    'location': 'No location',
                    'title': 'Empty event',
                    'description': 'Nothing to see here...',
                    'all-day': False
                }
                f = fr.readlines()
                i = 0
                for l in f:
                    if ':start' in l:
                        event['start'] = l[7:-1]
                    elif ':end' in l:
                        event['end'] = l[5:-1]
                    elif ':location' in l:
                        event['location'] = l[10:-1]
                    elif ':title' in l:
                        event['title'] = l[7:-1]
                    elif ':description' in l:
                        event['description'] = l[13:-1]
                        event['description'] = re.sub(r'\\n',r'\n',event['description'])
                        event['description'] = re.sub(r'\\,',r',',event['description'])
                    elif ':repeat ' in l:
                        if l[8:-1] == "daily":
                            repeat_freq = 1
                        elif l[8:-1] == "weekly":
                            repeat_freq = 7
                        elif l[8:-1] == "monthly":
                            repeat_freq = 30
                        elif l[8:-1] == "yearly":
                            repeat_freq = 365
                    elif ':repeat-until' in l:
                        repeat_until = l[14:-1]
                    elif ':no-repeat' in l:
                        no_repeat.append(datetime.strptime(l[11:-1], "%Y-%m-%d").date())
                    elif ':all-day' in l:
                        event['all-day'] = True
            events.append(event)
            if repeat_freq != 0:
                d = datetime.strptime(event['start'], "%Y-%m-%d %H:%M") 
                D = datetime.strptime(event['end'], "%Y-%m-%d %H:%M") if not event['all-day'] else "nope"
                dd = d 
                shift = 0
                while dd.date() < datetime.strptime(repeat_until, "%Y-%m-%d").date() and dd.date().year <= datetime.today().year + 1:
                    e2 = event.copy()
                    if repeat_freq in range(30):
                        shift += repeat_freq
                    elif repeat_freq == 30:
                        feb = 28 if (dd.year % 100 == 0 and dd.year % 400 != 0) \
                                 or (dd.year % 4 != 0) \
                                 else 29
                        shift += [0, 31, feb, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31][dd.month]
                    elif repeat_freq == 365:
                        shift += 365 if (dd.year % 100 == 0 and dd.year % 400 != 0) \
                                     or (dd.year % 4 != 0) \
                                     else 366
                    e2['start'] = datetime.utcfromtimestamp(int(d.strftime("%s")) + 86400 * shift + 3600) \
                        .astimezone(timezone('Europe/Berlin')).strftime("%Y-%m-%d %H:%M")
                    e2['end'] = datetime.utcfromtimestamp(int(D.strftime("%s")) + 86400 * shift + 3600) \
                        .astimezone(timezone('Europe/Berlin')).strftime("%Y-%m-%d %H:%M") if D != "nope" else "N/A"
                    #e2['variable'] = name+str(len(events))
                    dd = datetime.strptime(e2['start'], "%Y-%m-%d %H:%M")
                    if dd.date() not in no_repeat:
                        events.append(e2)
    return events

def dict_to_yuck(events):
    """Transforms the list of dicts into yuck syntax for use in eww.

    Args:
        events (list): A list of dictionaries representing events.

    Returns: 
        str: The events in yuck syntax.

    """
    o = ""
    for event in events:
        i = events.index(event)
        if not event['all-day']:
            duration = datetime.strptime(event['end'], "%Y-%m-%d %H:%M") - datetime.strptime(event['start'], "%Y-%m-%d %H:%M")
            duration_split = str(duration).split(':')
            h, m, s = duration_split[0], duration_split[1], duration_split[2]
            o += f"""
(eventnormal 
    :calendar "{event["calendar"]}"
    :title "{event["title"]}"
    :time "{event["start"]}, {h}h {m}m"
    :location "{event["location"]}"
    :description "{event["description"]}")
            """
        else:
            o += f"""
(eventallday
    :calendar "{event["calendar"]}"
    :title "{event["title"]}"
    :time "{event["start"].split(" ")[0]}")
            """
    return o

def normal_print(events):
    """Prints the list of dicts in a human-readable format.

    Args:
        events (list): A list of dictionaries representing events.

    Returns: 
        str: The events in yuck syntax.

    """
    print('——————————————————————————————————————')
    for event in events:
        duration = datetime.strptime(event['end'], "%Y-%m-%d %H:%M") - datetime.strptime(event['start'], "%Y-%m-%d %H:%M")
        duration_split = str(duration).split(':')
        h, m, s = duration_split[0], duration_split[1], duration_split[2]
        print("Name:",event['title'])
        print("Start:",event['start'])
        print("Duration:",f"{h}h {m}m")
        if 'location' in event:
            print("Where:",event['location'])
        if 'description' in event:
            print('\n'+event['description'])
        print('——————————————————————————————————————')

def create_event(calendar, count, title, start, all_day=False, end='N/A', 
        location='No location', description='Nothing to see here...'):
    """Creates an event from arguments.

    Args:
        calendar (str): The name of the calendar that the event will belong to.
        count (int): The number of the event in the calendar.
            Important for expando functionality.
        title (str): What the event is called.
        start (str): The start time of the event, in YYYY-MM-DD HH:MM format.
        all_day (bool): Whether the event spans an entire day. Defaults to False.
        end (str, optional): The end time of the event, in YYYY-MM-DD HH:MM format.
        location (str, optional): Where the event takes place.
        description (str, optional): Notes on the event.

    Returns:
        dict: A dictionary that represents the event.

    """
    return {
        'calendar': calendar, 
        #'variable': calendar+str(count),
        'start': start,
        'end': end, 
        'location': location,
        'title': title,
        'description': description,
        'all-day': all_day
    }

def boring_calendar(min_year=datetime.now().year, max_year=datetime.now().year+1):
    """Generates a calendar with mundane all-day events, such as holidays.

    Args:
        min_year (int): The lowest year to generate events for.
            Defaults to this year.

        max_year (int): The highest year to generate events for.
            Defaults to next year.
        
        If min_year and max_year are the same, events are only generated for
        one year.

    Returns:
        list: A list of dictionaries representing events.

    """

    def computus(y, offset):
        a = y % 19
        b = y//100
        c = y%100
        d = b//4
        e = b%4
        g = (8*b+13)//25
        h = (19*a+b-d-g+15)%30
        i = c//4
        k = c%4
        l = (32+2*e+2*i-h-k)%7
        m = (a+11*h+19*l)//433
        n = (h+l-7*m+90)//25
        p = (h+l-7*m+33*n+19)%32
        q = p + offset
        r = n
        months = [31, 30, 31, 30, 31]
        while q > months[r-3]:
            q -= months[r-3]
            r += 1
        return f"{year}-{r:02}-{q:02} 00:00"

    events = []
    event_template = {
        "New Year's Day": "-01-01",
        "super boring crap day": "-02-14",
        "Spring Equinox": "-03-20",
        "Vaffeldagen": "-03-25",
        "International Worker's Day": "-05-01",
        "17. mai": "-05-17",
        "Summer Solstice": "-06-21",
        "Autumn Equinox": "-09-23",
        "super boring fright day": "-10-31",
        "Winter Solstice": "-12-21",
        "Xmas Day": "-12-25"
    }
    i = 0
    for year in range(min_year, max_year+1):
        for name, date in event_template.items():
            events.append(create_event('boring', i, name, str(year)+date+" 00:00", True))
            i += 1
        events.append(create_event('boring', i, "Easter Sunday", computus(year, 0), True))
        i += 1
        events.append(create_event('boring', i, "Ascension Day", computus(year, 39), True))
        i += 1
        events.append(create_event('boring', i, "Pentecost Sunday", computus(year, 49), True))
        i += 1
    return events

def main(evts, date=""):
    """Main method that produces the yuck for eww.

    Args:
        evts (list): A list of dictionaries representing events.
        date (str): A YYYY-MM-DD format date string that determines what date
            to view events for.
            Defaults to an empty string.

    Returns:
        None.

    """
    events = [event for event in evts if event['start'].split(" ")[0] == date or date == ""]
    events.sort(key=lambda x : x['start'])
    wrapper = '(box :space-evenly false :class "eventwrapper" :orientation "v" :halign "start" :valign "start" {})'
    header = '(label :halign "start" :class "header" :text "{}") '
    text = ""
    if date == "":
        now = datetime.now()
        today = now.date()
        tomorrow = datetime.utcfromtimestamp(int(today.strftime("%s")) + 86400 * 2).date()
        seven_days_from_now = datetime.utcfromtimestamp(int(today.strftime("%s")) + 86400 * 7).date()
        events_current = []
        events_today = []
        events_tomorrow = []
        events_next_seven_days = []
        events_later = []
        for event in events:
            start = datetime.strptime(event['start'], "%Y-%m-%d %H:%M")
            start_date = start.date()
            if not event['all-day']:
                end = datetime.strptime(event['end'], "%Y-%m-%d %H:%M")
            else:
                end = start + timedelta(days=1)
            end_date = end.date()
            if end > now or (event['all-day'] and start_date == today):
                if start < now:
                    events_current.append(event)
                elif start_date == today:
                    events_today.append(event)
                elif start_date <= tomorrow:
                    events_tomorrow.append(event)
                elif start_date <= seven_days_from_now:
                    events_next_seven_days.append(event)
                else:
                    events_later.append(event)
        if len(events_current) > 0:
            text += header.format("Now") + dict_to_yuck(events_current) 
        if len(events_today) > 0:
            text += header.format("Today") + dict_to_yuck(events_today) 
        if len(events_tomorrow) > 0:
            text += header.format("Tomorrow") + dict_to_yuck(events_tomorrow) 
        if len(events_next_seven_days) > 0:
            text += header.format("Next 7 days") + dict_to_yuck(events_next_seven_days) 
        if len(events_later) > 0:
            text += header.format("Later") + dict_to_yuck(events_later) 
    else:
        if len(events) > 0:
            text += header.format("On this day") + dict_to_yuck(events)
    if text == "":
        text = header.format("No events :(")
    print(wrapper.format(text))

if __name__ == "__main__":
    events = \
              read_ics('/home/antoine/.config/vdir/calendars/UiO/', "uio") \
            + read_evt('/home/antoine/.calendar/work/', "work") \
            + read_evt('/home/antoine/.calendar/uio/', "uiocustom") \
            + read_ics('/home/antoine/.calendar/uio/', "uiocustom") \
            + read_ics('/home/antoine/.calendar/work/', "work") \
            + read_evt('/home/antoine/.calendar/dnd/', "dnd") \
            + read_evt('/home/antoine/.calendar/personal', "personal") \
            + read_evt('/home/antoine/.calendar/jojo/', "jojo") \
            + read_evt('/home/antoine/.calendar/lan', "lan") \
            + boring_calendar()

    """
    with open('/home/antoine/.config/eww/vars.yuck', 'w') as f:
        for event in events:
            f.write(f'(defvar {event["variable"]} false)\n')
    """
    if len(argv) > 1:
        ds = argv[1].split(".")
        d = int(ds[0])
        m = int(ds[1])+1
        y = int(ds[2])
        main(events, f'{y}-{m:02}-{d:02}')
    else:
        main(events)



"""
(box :space-evenly false :orientation "v" :class "event {event["calendar"]}" 
    (eventbox :halign "start" :valign "start" 
        :onhover "eww update {event["variable"]}=true" :onhoverlost "eww update {event["variable"]}=false" 
        (box :space-evenly false :orientation "v" :halign "start" :valign "start" :width 300 
            (label :halign "start" :style "font-weight: 700;" :text  "{event["title"]}") 
            (label :halign "start" :text "{event["start"]}, {h}h {m}m")
            (revealer :transition "slideup" :reveal {event["variable"]} :duration "200ms" 
                (box :space-evenly false :orientation "v" :halign "start" :valign "start" :class "eventinner" :width 300
                    (label :halign "start" :text "{event["location"]}") 
                    (label :width 300 :wrap true :halign "start" :text "{event["description"]}"))))))
"""
"""
(box :space-evenly false :orientation "v" :class "event {event["calendar"]}"
    (box :space-evenly false :orientation "v" :halign "start" :valign "start" :width 300
        (label :halign "start" :style "font-weight: 700;" :text "{event["title"]}")
        (label :halign "start" :text "{event["start"].split(" ")[0]}")))
"""
