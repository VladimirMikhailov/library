define("library/graphs", function() {
  return function graphs() {
    var attributes = (Library.data && Library.data.graphs) || {};

    for(attribute in attributes) {
      if (attributes.hasOwnProperty(attribute)) {
        this[attribute] =  attributes[attribute];
      }
    }
  }
});
