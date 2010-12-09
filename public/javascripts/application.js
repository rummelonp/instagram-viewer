var showFullPost = function(post_id) {
  var posts = document.getElementsByClassName('post');
  for (var i = posts.length - 1; i >= 0; i -= 1) {
    posts[i].id = '';
  }
  var post = document.getElementsByClassName(post_id)[0];
  post.id = 'full';
};

window.onload = function() {
  document.getElementsByClassName('post')[0].id = 'full';
};
