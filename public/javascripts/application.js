
var onClickDocument = function(event) {
  var post = Event.findElement(event, '.post');
  if (Object.isElement(post)) {
    if (event.altKey || event.ctlrKey ||
        event.metaKey || event.shiftKey)
    {
      return;
    }
    var current = $('full');
    Object.isElement(current) &&
      current.writeAttribute('id', null);
    post.writeAttribute('id', 'full');
    Event.stop(event);
  }
};

document.observe('dom:loaded', function(event) {
  var post = $$('.post').first();
  post.writeAttribute('id', 'full');
}.bindAsEventListener(), false);

document.observe('click', onClickDocument.bindAsEventListener(), false);
