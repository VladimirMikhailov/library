define(
  "library/widgets/infinite_scroll",
  [
    "jquery",
    "materialize"
  ],
  function($) {
    var $collection = null;

    function updateView(response) {
      var $responseCollection = $(response);
      $collection.append($responseCollection.html());
      setFire($responseCollection);
    }

    function setFire($collection) {
      var path = $collection.data("path");
      var $last = $collection.find(".collection-item:last");

      var options = [
        {
          selector: "#" + $last.prop("id"),
          offset: -400,
          callback: 'globalUpdateBooksView("' + path + '")'
        },
      ];

      Materialize.scrollFire(options);
    }

    $.fn.infiniteScroll = function() {
      $collection = $(this);
      setFire($collection);

      window.globalUpdateBooksView = function(path) {
        $.get(path, updateView)
      }
    }
  }
);
