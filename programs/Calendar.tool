/*
 * This program simulates year 2014... yaay !
 *
 */
 
 object Calendar {
 	def main(): Unit = {
		println(new Launcher().start());
 	}
 }
 
 class Launcher {
 	def start() : String = {
 		var ret : String;
 		var calendar : Year;
 		
 		println(" ===== Programm started here ===== ");
 		
 		calendar = new CalendarClass().newYear();
 		
 		if(calendar.print())
 			ret = " ==== Programm ended here ==== ";
 		else
 			ret = " ==== Failure detected ==== ";
 			
 		return ret;
 	}
 }
 
 class CalendarClass {
 	
 	def newYear() : Year = {
 		
 		var year : Year;
 		var days : Int[];
 		days = new Int[12];
 		
 		days[0] = 31;
 		days[1] = 29;
 		days[2] = 31;
 		days[3] = 30;
 		days[4] = 31;
 		days[5] = 30;
 		days[6] = 31;
 		days[7] = 31;
 		days[8] = 30;
 		days[9] = 31;
 		days[10] = 30;
 		days[11] = 31;
 		
 		year = new Year().initY(2014, "January", days);
 		
 		return year;
 	}
 }
 
 class Year extends Base {
 	var january : Month;
 	var february : Month;
 	var march : Month;
 	var april : Month;
 	var may : Month;
 	var june : Month;
 	var july : Month;
 	var august : Month;
 	var september : Month;
 	var october : Month;
 	var november : Month;
 	var december : Month;
 	var currentMonth : Month;
 	var year : Int;
 	
 	def initY(y : Int, curM : String, d: Int[]) : Year = {
 		var useless : String;
 		
 		if(true){
	 		january = new Month().initM(d[0], "Wednesday", "January");
	 		february = new Month().initM(d[1], "Saturday", "February");
	 		march = new Month().initM(d[2], "Saturday", "March");
	 		april = new Month().initM(d[3], "Tuesday", "April");
	 		may = new Month().initM(d[4], "Thursday", "May");
	 		june = new Month().initM(d[5], "Sunday", "June");
	 		july = new Month().initM(d[6], "Tuesday", "July");
	 		august = new Month().initM(d[7], "Friday", "August");
	 		september = new Month().initM(d[8], "Monday", "September");
	 		october = new Month().initM(d[9], "Wednesday", "October");
	 		november = new Month().initM(d[10], "Saturday", "November");
	 		december = new Month().initM(d[11], "Monday", "December");
	 	}
 		
 		useless = this.setCurrentMonth(curM);
 		
 		year = y;
 		
 		return this;
 	}
 	
 	def setCurrentMonth(monthName: String) : String = {
 		if(monthName == "January")
 			currentMonth = january;
 		else if(monthName == "February")
 			currentMonth = february;
 		else if(monthName == "March")
 			currentMonth = march;
 		else if(monthName == "April")
 			currentMonth = april;
 		else if(monthName == "May")
 			currentMonth = may;
 		else if(monthName == "June")
 			currentMonth = june;
 		else if(monthName == "July")
 			currentMonth = july;
 		else if(monthName == "August")
 			currentMonth = august;
 		else if(monthName == "September")
 			currentMonth = september;
 		else if(monthName == "October")
 			currentMonth = october;
 		else if(monthName == "November")
 			currentMonth = november;
 		else if(monthName == "December")
 			currentMonth = december;
 			
 		return monthName;
 	}
 	
 	def getCurrentMonth() : Month = {
 		return currentMonth;
 	}
 	
 	def getYear() : Int = {
 		return year;
 	}
 	
 	def print() : Bool = {
 		println(" >> Now testing overriding methods << ");
 		println("Year : " + year);
 		
 		return this.getCurrentMonth().print();
 	}
 }
 
 class Month extends Base {
 	var numOfDays : Int; // 29, 30, 31
 	var currentDay : Day;
 	
 	def initM(num : Int, nameOfFirstDay : String, monthName : String) : Month = {
 		currentDay = new Day().initD(nameOfFirstDay, 1);
 		name = monthName;
 		numOfDays = num;
 		
 		return this;
 	}
 	
 	def print() : Bool = {
 		println("Month : "+ name);
 		return currentDay.print();
 	}
 }
 
 class Day extends Base{
 	var date : Int;
 	var intValue : Int;
 	
 	def initD(dayName : String, dayDate : Int) : Day = {
 		name = dayName;
 		intValue = this.convertToInt(dayName);
 		date = dayDate;
 		
 		return this;
 	}
 	
 	def print() : Bool = {
 		println("Day : " + name);
 		println("- - - - - - -");
 		println(" >> Yay ! It works << ");
 		return true;
 	}
 	
 	def convertToInt(n : String) : Int = {
 		var ret : Int;
 		
 		if(n == "Monday")
 			ret = 1;
 		else if(n == "Tuesday")
 			ret = 2;
 		else if(n == "Wednesday")
 			ret = 3;
 		else if(n == "Thursday")
 			ret = 4;
 		else if(n == "Friday")
 			ret = 5;
 		else if(n == "Saturday")
 			ret = 6;
 		else if(n == "Sunday")
 			ret = 7;
 		else
 			ret = 0-1;
 			
 		return ret;
 	}
 }
 
 class Base extends Test {
 	var name : String;
 	
 	def getName() : String = {
 		return name;
 	}
 }
 
 class Test {
 	def print() : Bool = {
 		return true;
 	}
 }