define(
  "library/widgets/top_authors_graph",
  [
    "jquery",
    "library",
    "library/top_authors_datasets",
    "library/line_dataset_builder",
    "chartjs"
  ],
  function($, library, Dataset, datasetBuilder, Chart) {
    $.fn.topAuthorsGraph = function() {

      function datasets() {
        var datasets = new Dataset().all();
        var result = [];

        for(var index = 0; index < datasets.length; index++) {
          result.push(datasetBuilder(index, datasets[index]));
        }

        return result;
      }

      return this.each(function() {
        new Chart(this.getContext("2d")).Line({
          labels: library.yearLabels,
          datasets: datasets()
        }, {animation: false});
      });
    }
  }
);
