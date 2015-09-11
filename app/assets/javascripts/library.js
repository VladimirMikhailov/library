define("library", function() {
  var minYear = 1940;
  var maxYear = 2015;

  function yearLabels() {
    var labels = [];

    for (var year = minYear; year <= maxYear; year++) {
      labels.push(String(year))
    }

    return labels;
  }

  return {
    minYear: minYear,
    maxYear: maxYear,
    graph: function(data) {
      return {
        label: "Graph",
        fillColor: "rgba(38, 166, 154,0.5)",
        strokeColor: "rgba(0, 150, 136,0.8)",
        highlightFill: "rgba(220,220,220,0.75)",
        highlightStroke: "rgba(220,220,220,1)",
        data: data
      }
    },
    yearLabels: yearLabels(),
    letterLabels: "ABCDEFGHIJKLMNOPQRSTUVWXYZ".split("")
  }
});
