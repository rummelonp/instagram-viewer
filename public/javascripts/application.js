var showFullPost = function(post_id) {
  var post = document.getElementById('full');
  if (post) {
    post.id = '';
  }
  document.getElementsByClassName(post_id)[0].id = 'full';
};

window.onload = function() {
  var post = document.getElementById('full');
  if (!post) {
    document.getElementsByClassName('post')[0].id = 'full';
  }
};
