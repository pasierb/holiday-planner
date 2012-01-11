// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready( function(){
  
  // register onClick hook
  //
  $(".day").click( function(){ return false; } );
  $(".clickable").click( function(){ 
    markDay( $(this) ) 
    return false;
  });


  // creates bubble popup for holidays
  //
  $('.holiday').each( function(i){
    $(this).CreateBubblePopup({ 
      innerHtml: $(this).attr('title'),
      selectable: true,
      themeName: 'all-black',
      themePath: '/images/jquerybubblepopup-theme'
    });
  });

  $("#wysuwany_div").mouseover(function() {
    $("#wysuwany_div").stop();
    $("#wysuwany_div").animate({ right: "0" },350 );
  });
        
  $("#wysuwany_div").mouseout(function() {
    $("#wysuwany_div").stop();
    $("#wysuwany_div").animate({ right: "-209" }, 350 );
  });

  //Tabs
  //When page loads...
  $(".tab_content").hide(); //Hide all content
  $("ul.tabs li:first").addClass("active").show(); //Activate first tab
  $(".tab_content:first").show(); //Show first tab content

  //On Click Event
  $("ul.tabs li").click(function() {

    $("ul.tabs li").removeClass("active"); //Remove any "active" class
    $(this).addClass("active"); //Add "active" class to selected tab
    $(".tab_content").hide(); //Hide all tab content

    var activeTab = $(this).find("a").attr("href"); //Find the href attribute value to identify the active tab + content
    $(activeTab).fadeIn(); //Fade in the active ID content
    return false;
  });
  
} );

function markDay(d) {
  if( d.hasClass('leave') ) {
    if( deleteDay(d) ) markDownDay(d);
  }else {
    if( saveDay(d) ) markUpDay(d);
  }
  storeMarkedDays( new Date(d.attr('id')).getFullYear() );
}
  

function markUpDay(d) {
  if( !d.hasClass('leave') ){ 
    d.addClass('leave'); 
    markPeriod(d);
  }
  updateLeaveCounter();
}

function markDownDay(d) {
  d.removeClass('leave');
  unmarkPeriod(d);
  updateLeaveCounter();
}

function markPeriod(d) {
  nxt = d;
  do {
    markDayAsPeriod(nxt,'fwd-period');
    nxt = nextDay(nxt);
  } while( isFree(nxt) )  
  prev = d;
  do {
    markDayAsPeriod(prev,'rvs-period')
    prev = prevDay(prev)
  } while( isFree(prev) )
}

function unmarkPeriod(d) {
  nxt = d;
  do {
    unmarkDayAsPeriod( nxt, 'fwd-period', !nxt.hasClass('rvs-period') );
    nxt = nextDay(nxt);
  } while( isFree(nxt) )  
  
  prev = d;
  do {
    unmarkDayAsPeriod( prev,'rvs-period', !prev.hasClass('fwd-period') );
    prev = prevDay(prev);
  } while( isFree(prev) )
}

function nextDay(d) {
  try {
    if( d.hasClass('last-day-of-month') ) {
      nxt = d.parent().parent().next().next().find("td a.day").first();
    } else { nxt = d.parent().next('td').children().first(); }
    return nxt;
  } catch(e) { return null; }
}

function prevDay(d) {
  try {
    if( d.hasClass('first-day-of-month') ) {
      nxt = d.parent().parent().prev().prev().find("td a.day").last();
    } else {
      nxt = d.parent().prev('td').children().first();
    }
    return nxt;
  } catch(e) {
    return null;
  }
}

function isFree(d) {
  return ( isWeekend(d) || isHoliday(d) )
}

function isWeekend(d){
  if( d == null ) return false;
  return d.hasClass("weekend")
}

function isHoliday(d){
  if( d == null ) return false;
  return d.hasClass("holiday")
}
  
function markDayAsPeriod(d, klass) {
  d.addClass("period "+klass);
}
  
function unmarkDayAsPeriod(d, klass, cond) {
  if(cond) d.removeClass('period');
  d.removeClass(klass);
}

function updateLeaveCounter() {
  $("#leave-count").text( $(".leave").length );
  $("#period-count").text( $(".period").length );
}

function toggleIntMenu( menu ) {
  if( $("div#"+menu+"-choose").css('display') != 'block' ){
    $(".int-menu").hide();
    $(".int-menu-link").removeClass('current-int-menu');
    showIntMenu( menu );
  }else {
    hideIntMenu( menu );
  }
}

function showIntMenu( menu ) {
  $("#"+menu).addClass('current-int-menu');
  $("div#"+menu+"-choose").show();
}

function hideIntMenu( menu ) {
  $("#"+menu).removeClass('current-int-menu');
  $("div#"+menu+"-choose").hide();
}

function getMarkedDaysIds(){
  return $.map( $('.leave'), function(d,i){ return $(d).attr('id') } );
}

function storeMarkedDays( year ){
  $.jStorage.set( "holidayplanner_"+year, getMarkedDaysIds() );
}

function getStoredDaysIds( year ){
  return $.jStorage.get( "holidayplanner_"+year );
}

function markStoredDays( year ){
  leave = getStoredDaysIds( year );
  if( leave ){
    $.each( leave, function(k,d){ markUpDay( $( '#'+d ) ) } );
  }
}