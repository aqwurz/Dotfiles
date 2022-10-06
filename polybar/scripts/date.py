from datetime import datetime as dt

ordinals = [
    "th", "st", "nd", "rd", "th", "th", "th", "th", "th", "th",
    "th", "th", "th", "th", "th", "th", "th", "th", "th", "th",
    "th", "st", "nd", "rd", "th", "th", "th", "th", "th", "th",
    "th", "st", "nd", "rd", "th", "th", "th", "th", "th", "th"
]
today = dt.now()
#today = dt(2022,1,2,15,0)
t_iso = today.isocalendar()
snapshot = f"{str(t_iso[0])[2:4]}w{t_iso[1]:02}{['a','b','c','d','e','f','g'][t_iso[2]-1]}"
fancy_dates = {
    "01-01": "Happy New Year!",
    "02-14": "<3",
    "02-29": "ERROR",
    "03-08": "Int'l Women's Day",
    "03-14": "π day",
    "04-01": "April Fool's Day",
    "05-01": "Int'l Worker's Day",
    "05-04": "May the 4th",
    "05-17": "17. mai",
    "07-15": "July the 15th",
    "07-16": "Bizarre Summer",
    "07-22": "22. juli",
    "07-25": "Christmas in July",
    "08-26": "Happy Install Day!",
    "09-21": "the 21st night of September",
    #"09-25": "unPESTing Day",
    "09-28": "Happy Birthday!",
    "10-20": "Freedom from IN3130 Day",
    "10-31": "Spooktober",
    #f"11-{today.day:02}": f"the {today.day}{ordinals[today.day]} day of NNN",
    "12-24": "Xmas Eve",
    "12-25": "Xmas Day",
}
fancy_times = {
    "00:00": "99:59",
    "01:00": ":q!",
    "02:00": "2AM",
    "04:20": "weed",
    #"10:00": "mood",
    "14:37": "14.37",
    #"15:00": "end",
    #"17:00": "mood",
}
months = [
    "Fiddlesticks", "January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"
]
dm_raw = f"{today.month:02}-{today.day:02}" 
if dm_raw not in fancy_dates:
    dm = f"the {today.day}{ordinals[today.day]} of {months[today.month]}"
else:
    dm = f"{fancy_dates[dm_raw]}"
hm_raw = f"{today.hour:02}:{today.minute:02}"
if hm_raw not in fancy_times:
    hm = hm_raw
else:
    hm = f"{fancy_times[hm_raw]}"
print(f"{snapshot}, {dm} 1{today.year} | {hm}")
