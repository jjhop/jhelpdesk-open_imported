Event.observe(window, 'load', loadTabs, false);
function loadTabs() {
    var tabs = new tabset('currentWeekTabView', {
        classNames: {
            tab: 'tab',
            panel: 'Page',
            tabActive: 'Active'
        },
        ids: {
            tab: 'tab_',
            panel: 'panel_'
        },
        onEvent: 'click',
        effects: true
    });
    tabs.autoActivate($('tab_comments'));
}

function textToggle(txtChange, txtCancel) {
    var disp = $('assignActions').style.display;
    var text = txtChange;
    if(disp == 'none') {
        text = txtCancel;
    }
    else {
        text = txtChange;
    }
    $('btnAssignActions').innerHTML = text;
}
$('btnChangePr').hide();
$('btnChangeCat').hide();
