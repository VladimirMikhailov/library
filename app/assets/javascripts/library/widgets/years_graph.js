define(
  "library/widgets/years_graph",
  ["jquery", "library", "library/graphs", "chartjs"],
  function($, library, Graphs, Chart) {
    $.fn.yearsGraph = function() {

      function data() {
        return new Graphs()["publishments_by_years"];
      }

      return this.each(function() {
        new Chart(this.getContext("2d")).Line({
          labels: library.yearLabels,
          datasets: [library.graph(data())]
        });
      });
    }
  }
);
