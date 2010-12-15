
var onClickDocument = function(event) {
  var post = Event.findElement(event, '.post');
  if (Object.isElement(post)) {
    if (event.altKey || event.ctlrKey ||
        event.metaKey || event.shiftKey)
    {
      return;
    }
    Event.stop(event);
    var current = $('full');
    Object.isElement(current) &&
      current.writeAttribute('id', null);
    post.writeAttribute('id', 'full');
  }
};

var onSubmitFindForm = function(event) {
  var form = Event.element(event);
  Event.stop(event);
  form.request();
};

document.observe('dom:loaded', function(event) {
  var post = $$('.post').first();
  post.writeAttribute('id', 'full');
  var form = $$('#find form').first();
  form.addEventListener('submit', onSubmitFindForm, false);
}.bindAsEventListener(), false);

document.observe('click', onClickDocument.bindAsEventListener(), false);
