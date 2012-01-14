//Day object
function Day( html_element ){

  //html_element coresponding do this day
  this.element = $(html_element);

  //Id which is actually date string
  this.id = function(){ return this.element.attr('id') };
  
  //date wrapped in js Date object
  this.date = function(){ return new Date( this.element.attr('id') ) };
  
  this.getPeriodId = function(){ return this.element.attr( 'data-period_id' ) };
  
  this.setPeriodId = function( period_id ){ return this.element.attr( 'data-period_id', period_id ) };
  
  this.removePeriodId = function(){ return this.element.removeAttr( 'data-period_id' ); };
  
  this.isFree = function() { return ( this.isWeekend() || this.isHoliday() ) };
  
  this.isWeekend = function(){ return this.element.hasClass("weekend") };
  
  this.isHoliday = function(){ return this.element.hasClass("holiday") };
  
  this.isLeave = function(){ return this.element.hasClass('leave') };
  
  this.setLeave = function( set ){ set ? this.element.addClass('leave') : this.element.removeClass('leave'); };
  
  this.isPeriod = function(){ return this.element.hasClass('period') };
  
  this.next = function() {
    try {
      if( this.element.hasClass('last-day-of-month') ) {
        nxt = this.element.parent().parent().next().next().find("td a.day").first();
      } else { nxt = this.element.parent().next('td').children().first(); }
      return new Day( nxt );
    } catch(e) { return null; }
  };
  
  this.prev = function() {
    try {
      if( this.element.hasClass('first-day-of-month') ) {
        nxt = this.element.parent().parent().prev().prev().find("td a.day").last();
      } else {
        nxt = this.element.parent().prev('td').children().first();
      }
      return new Day( nxt );
    } catch(e) {
      return null;
    }
  };
  
  this.markAsPeriod = function( period_id ) {
    this.element.addClass( "period" );
    this.setPeriodId( period_id );
  };
  
  this.unmarkAsPeriod = function() {
    this.element.removeClass( 'period' );
    this.removePeriodId();
  };
  
  this.mark = function() {
    if( this.isLeave() ) {
      if( deleteDay( this.element ) ) this.markDown();
    }else {
      if( saveDay( this.element ) ) this.markUp();
    }
    storeMarkedDays( this.date().getFullYear() );
  };
  
  this.markUp = function() {
    if( !this.isLeave() ){ 
      this.setLeave( true );
      markPeriod( this.element );
    }
    updateLeaveCounter();
  }
  
  this.markDown = function() {
    this.setLeave( false );
    unmarkPeriod( this.element );
    updateLeaveCounter();
  }
}