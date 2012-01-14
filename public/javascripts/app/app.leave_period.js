//LeavePeriod object
function LeavePeriod( days_array ){

  this.days = days_array;
  
  this.leave = function(){
    var l = new Array();
    $.each( this.days, function(i,day){
      if( day.isLeave() ){ l.push( day ) }
    });
    return l;
  };
  
  this.since = function(){ return this.days[0].id() };
  
  this.to = function(){ return this.days[this.days.length-1].id() };
  
  this.leave_since = function(){ return this.leave().length > 0 ? this.leave()[0].id() : null };
  
  this.leave_to = function(){ return this.leave().length > 0 ? this.leave()[this.leave().length-1].id() : null };
  
  this.span = function(){
    if( this.days.length > 1 ){
      return this.since()+" - "+this.to(); 
    }else {
      return this.days[0].id();
    }
  };
  
  this.print = function(){
    $("#periords-list").append("<tr>"+
      "<td>"+this.span()+"</td>"+
      "<td>"+this.days.length+"</td>"+
      "<td>"+this.leave().length+"</td>"+
      "<td><a href='leave_request.pdf?total="+this.leave().length+"&since="+this.leave_since()+"&to="+this.leave_to()+"'>pdf</a></td>"+
    "</tr>");
  };

}