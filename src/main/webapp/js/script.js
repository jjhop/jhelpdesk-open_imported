// nowe funkcje
function updateDiv(triggerId, sourceUrl) {
    var targetDiv  = triggerId.substr(0, triggerId.length-3);
    var imgElement = $(triggerId).firstDescendant();
    new Ajax.Updater(targetDiv, sourceUrl, {
        method: 'get',
        onCreate: function() {
            imgElement.writeAttribute('src', '/jhd/themes/blue/i/btn_refresh_loader.gif');
        },
        onComplete: function() {
            setTimeout(function () {
                imgElement.writeAttribute('src', '/jhd/themes/blue/i/btn_refresh.png');
            }, 1000);
        }
    });
}

// stare funkcje
function clearForm(f) {
    for (var i = 0; i < f.notifiers.length; i++) {
        f.notifiers.options[i].selected = false;
    }
    for (i = 0; i < f.saviours.length; i++) {
        f.saviours.options[i].selected = false;
    }
    for (i = 0; i < f.ticketPriorities.length; i++) {
        f.ticketPriorities.options[i].selected = false;
    }
    for (i = 0; i < f.ticketStatuses.length; i++) {
        f.ticketStatuses.options[i].selected = false;
    }
    for (i = 0; i < f.ticketCategories.length; i++) {
        f.ticketCategories.options[i].selected = false;
    }
    f.beginDate.value = "";
    f.endDate.value = "";
}

function toggleForm() {
    $('filterbox').toggle();
    $('filterbutton').blur();
}

function none() {}

/***********************************************
 * Switch Content script II- © Dynamic Drive (www.dynamicdrive.com)
 * This notice must stay intact for legal use. Last updated April 2nd, 2005.
 * Visit http://www.dynamicdrive.com/ for full source code
 ***********************************************/

var enablepersist="on" //Enable saving state of content structure using session cookies? (on/off)
var memoryduration="7" //persistence in # of days

var contractsymbol='../../../commons/i/minus.gif' //Path to image to represent contract state.
var expandsymbol='../../../commons/i/plus.gif' //Path to image to represent expand state.

/////No need to edit beyond here //////////////////////////

function getElementbyClass(rootobj, classname) {
    var temparray=new Array();
    var inc = 0;
    var rootlength = rootobj.length;
    for (i = 0; i < rootlength; i++) {
        if (rootobj[i].className == classname)
            temparray[inc++] = rootobj[i];
    }
    return temparray;
}

function sweeptoggle(ec) {
    var inc = 0;
    while (ccollect[inc]) {
        ccollect[inc].style.display = (ec == "contract" ) ? "none" : "";
        inc++;
    }
    revivestatus();
}


function expandcontent(curobj, cid) {
    if (ccollect.length > 0) {
        document.getElementById(cid).style.display = (document.getElementById(cid).style.display != "none") ? "none" : "";
        curobj.src = (document.getElementById(cid).style.display == "none") ? expandsymbol : contractsymbol;
    }
}

function revivecontent() {
    selectedItem = getselectedItem();
    selectedComponents = selectedItem.split("|");
    for (i = 0; i < selectedComponents.length - 1; i++) {
        document.getElementById(selectedComponents[i]).style.display = "none";
    }
}

function revivestatus(){
    var inc=0
    while (statecollect[inc]){
        if (ccollect[inc].style.display=="none")
            statecollect[inc].src=expandsymbol
        else
            statecollect[inc].src=contractsymbol
        inc++
    }
}

function get_cookie(Name) {
    var search = Name + "="
    var returnvalue = "";
    if (document.cookie.length > 0) {
        offset = document.cookie.indexOf(search)
        if (offset != -1) {
            offset += search.length
            end = document.cookie.indexOf(";", offset);
            if (end == -1) end = document.cookie.length;
            returnvalue=unescape(document.cookie.substring(offset, end))
        }
    }
    return returnvalue;
}

function getselectedItem(){
    return (get_cookie(window.location.pathname) != "")
        ? get_cookie(window.location.pathname)
        : '';
}

function saveswitchstate(){
    var inc=0, selectedItem="";
    while (ccollect[inc]){
        if (ccollect[inc].style.display == "none"){
            selectedItem += ccollect[inc].id + "|";
        }
        inc++
    }
    if (get_cookie(window.location.pathname) != selectedItem){ //only update cookie if current states differ from cookie's
        var expireDate = new Date()
        expireDate.setDate(expireDate.getDate()+parseInt(memoryduration))
        document.cookie = window.location.pathname+"="+selectedItem+";path=/;expires=" + expireDate.toGMTString()
    }
}

function do_onload(){
    uniqueidn=window.location.pathname+"firsttimeload"
    var alltags=document.all? document.all : document.getElementsByTagName("*")
    ccollect=getElementbyClass(alltags, "switchcontent")
    statecollect=getElementbyClass(alltags, "showstate")
    if (enablepersist=="on" && get_cookie(window.location.pathname)!="" && ccollect.length>0)
        revivecontent()
    if (ccollect.length>0 && statecollect.length>0)
        revivestatus()
}

if (window.addEventListener)
    window.addEventListener("load", do_onload, false)
else if (window.attachEvent)
    window.attachEvent("onload", do_onload)
else if (document.getElementById)
    window.onload=do_onload

if (enablepersist=="on" && document.getElementById)
    window.onunload=saveswitchstate

