define(
  "library/widgets/first_letters_graph",
  ["jquery", "library", "library/graphs", "chartjs"],
  function($, library, Graphs, Chart) {
    $.fn.firstLettersGraph = function() {

      function data() {
        return new Graphs()["books_by_first_letters"];
      }

      return this.each(function() {
        new Chart(this.getContext("2d")).Bar({
          labels: library.letterLabels,
          datasets: [library.graph(data())]
        }, {animation: false});
      });
    }
  }
);
