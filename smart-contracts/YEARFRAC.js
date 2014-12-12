// Copyright (c) 2012 Sutoiku, Inc. (MIT License)
if (typeof define !== 'function') {
    var define = require('amdefine')(module);
}

define(['moment'], function(moment) {
return {
"YEARFRAC" : function YEARFRAC(start_date, end_date, basis) {
  // Credits: David A. Wheeler [http://www.dwheeler.com/]

  // Initialize parameters
  var basis = (typeof basis === 'undefined') ? 0 : basis;
  var sdate = moment(new Date(start_date));
  var edate = moment(new Date(end_date));

  // Return error if either date is invalid
  if (!sdate.isValid() || !edate.isValid()) return '#VALUE!';

  // Return error if basis is neither 0, 1, 2, 3, or 4
  if ([0,1,2,3,4].indexOf(basis) === -1) return '#NUM!';
  
  // Return zero if start_date and end_date are the same
  if (sdate === edate) return 0;
  
  // Swap dates if start_date is later than end_date
  if (sdate.diff(edate) > 0) {
    var edate = moment(new Date(start_date));
    var sdate = moment(new Date(end_date)); 
  }

  // Lookup years, months, and days
  var syear = sdate.year();
  var smonth = sdate.month();
  var sday = sdate.date();
  var eyear = edate.year();
  var emonth = edate.month();
  var eday = edate.date();

  switch (basis) {
    case 0:
      // US (NASD) 30/360
      // Note: if eday == 31, it stays 31 if sday < 30
      if (sday === 31 && eday === 31) {
        sday = 30;
        eday = 30;
      } else if (sday === 31) {
        sday = 30;
      } else if (sday === 30 && eday === 31) {
        eday = 30;
      } else if (smonth === 1 && emonth === 1 && sdate.daysInMonth() === sday && edate.daysInMonth() === eday) {
        sday = 30;
        eday = 30;
      } else if (smonth === 1 && sdate.daysInMonth() === sday) {
        sday = 30;
      }
      return ((eday + emonth * 30 + eyear * 360) - (sday + smonth * 30 + syear * 360)) / 360;
      break;

    case 1:
      // Actual/actual
      var feb29Between = function(date1, date2) {
        // Requires year2 == (year1 + 1) or year2 == year1
        // Returns TRUE if February 29 is between the two dates (date1 may be February 29), with two possibilities:
        // year1 is a leap year and date1 <= Februay 29 of year1
        // year2 is a leap year and date2 > Februay 29 of year2
  
        var mar1year1 = moment(new Date(date1.year(), 2, 1));
        if (moment([date1.year()]).isLeapYear() && date1.diff(mar1year1) < 0 && date2.diff(mar1year1) >= 0) {
          return true;
        } 
        var mar1year2 = moment(new Date(date2.year(), 2, 1));
        if (moment([date2.year()]).isLeapYear() && date2.diff(mar1year2) >= 0 && date1.diff(mar1year2) < 0) {
          return true;
        }
        return false;
      };
      var ylength = 365;
      if (syear === eyear || ((syear + 1) === eyear) && ((smonth > emonth) || ((smonth === emonth) && (sday >= eday)))) {
        if (syear === eyear && moment([syear]).isLeapYear()) {
          ylength = 366;
        } else if (feb29Between(sdate, edate) || (emonth === 1 && eday === 29)) {
          ylength = 366;
        }
        return edate.diff(sdate, 'days') / ylength;
      } else {
        var years = (eyear - syear) + 1;
        var days = moment(new Date(eyear + 1, 0, 1)).diff(moment(new Date(syear, 0, 1)), 'days');
        var average = days / years;
        return edate.diff(sdate, 'days') / average;
      }
      break;

    case 2:
      // Actual/360
      return edate.diff(sdate, 'days') / 360;
      break;

    case 3:
      // Actual/365
      return edate.diff(sdate, 'days') / 365;
      break;

    case 4:
      // European 30/360
      if (sday === 31) sday = 30;
      if (eday === 31) eday = 30;
      // Remarkably, do NOT change February 28 or February 29 at ALL
      return ((eday + emonth * 30 + eyear * 360) - (sday + smonth * 30 + syear * 360)) / 360;
      break;
  }
}
}
});
