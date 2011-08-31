Accordion = Class.create();
Accordion.prototype = {
    initialize: function(elem, clickableEntity) {
        this.container = $(elem);
        var headers = $$('#' + elem + ' .' + clickableEntity);

        headers.each(function(header) {
            Event.observe(header,'click',this.sectionClicked.bindAsEventListener(this));
        }.bind(this));
    },
    sectionClicked: function(event) {
        this.closeExistingSection();
        Event.element(event).parentNode.nextElementSibling.addClassName("current");
        //Event.element(event).parentNode.nextElementSibling.show();
        Effect.Appear(Event.element(event).parentNode.nextElementSibling);
    },
    openSection: function(section) {
        $(section).show();
    },
    closeExistingSection: function() {
        var contents = document.getElementsByClassName('accordion_content');
        for(var i=0; i < contents.length; i++) {
            contents[i].removeClassName("current");
            contents[i].hide();
        }
    }
}