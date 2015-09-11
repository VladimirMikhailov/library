requirejs.config({
  enforceDefine: true,
  paths: {
    jquery: [
      "https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min",
      "vendor/jquery.min"
    ],
    materialize: [
      "https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.0/js/materialize.min",
      "vendor/materialize.min"
    ],
    chartjs: [
      "https://cdnjs.cloudflare.com/ajax/libs/Chart.js/1.0.2/Chart.min",
      "vendor/chart.min"
    ],
    hammerjs: [
      "https://cdnjs.cloudflare.com/ajax/libs/hammer.js/2.0.4/hammer.min",
      "vendor/hammer.min"
    ]
  },

  shim: {
    "materialize": ["jquery", "hammerjs"],
    "hammser": {exports: "Hammer" },
    "chartjs": {exports: "Chart" }
  }
});

requirejs(
  [
    "jquery",
    "materialize",
    "library/widgets/first_letters_graph",
    "library/widgets/years_graph",
    "library/widgets/top_authors_graph",
    "library/widgets/infinite_scroll"
  ],
  function($) {
    $(".by-years-chart").yearsGraph();
    $(".top-authors-chart").topAuthorsGraph();
    $(".by-first-letters-chart").firstLettersGraph();
    $(".collection").infiniteScroll();
  }
);
