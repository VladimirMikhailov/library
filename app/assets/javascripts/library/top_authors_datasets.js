define(
  "library/top_authors_datasets",
  ["library/graphs", "library"],
  function(Graphs, library) {
    function topAuthors() {
      this.authorsPublishments = new Graphs()["top_authors_publishments"] || [];
    }

    function buildYears(publishments) {
      var years = [];

      for (var year = library.minYear; year <= library.maxYear; year++) {
        years.push(parseInt(publishments[String(year)]) || 0);
      }

      return years;
    }

    topAuthors.prototype.all = function() {
      var authors = [];

      this.authorsPublishments.forEach(function(author) {
        authors.push({
          label: author.name,
          data: buildYears(author.publishments || {})
        });
      });

      return authors;
    }

    return topAuthors;
});
