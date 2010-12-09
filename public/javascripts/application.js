
(function() {

  const isDebug = true;

  var log = function() {
    if (isDebug && window.console) {
      if (console.debug) {
        return console.debug;
      }
      return console.log;
    }
    return Prototype.K;
  }();

  var getParentElementByAttributeRegExp = function(element, attribute, regexp) {
    var parent_element = $(element);
    do {
      if (regexp.test(parent_element.readAttribute(attribute))) {
        return parent_element;
      }
      parent_element = $(parent_element.parentNode);
    } while (parent_element);
    return null;
  };

  Object.extend(Element.prototype, {
    getParentElementByAttributeRegExp: getParentElementByAttributeRegExp.methodize()
  });

  var showFullPost = function(post) {
    post = $(post);
    $$('#full').each(function(e) e.writeAttribute('id', null));
    post.writeAttribute('id', 'full');
  };

  var onClickDocument = function(event) {
    var target = $(event.target);
    log(event, target);

    var photo = target.getParentElementByAttributeRegExp('class', /thumbnail/);
    if (photo) {
      event.stop();
      var post = photo.getParentElementByAttributeRegExp('class', /post/);
      showFullPost(post);
    };
  };

  document.observe('click', onClickDocument.bindAsEventListener(), false);

})();
