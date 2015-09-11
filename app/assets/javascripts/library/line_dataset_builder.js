define("library/line_dataset_builder", function() {
  var FILL_COLORS = [
    { fill: "rgba(239, 154, 154, 0.2)", stroke: "rgba(244, 143, 177, 1)" },
    { fill: "rgba(255, 205, 210, 0.2)", stroke: "rgba(229, 115, 115, 1)" },
    { fill: "rgba(225, 190, 231, 0.2)", stroke: "rgba(206, 147, 216, 1)" },
    { fill: "rgba(187, 222, 251, 0.2)", stroke: "rgba(144, 202, 249, 1)" },
    { fill: "rgba(178, 223, 219, 0.2)", stroke: "rgba(128, 203, 196, 1)" },
    { fill: "rgba(240, 244, 195, 0.2)", stroke: "rgba(230, 238, 156, 1)" },
    { fill: "rgba(255, 204, 128, 0.2)", stroke: "rgba(255, 183, 77, 1)" },
    { fill: "rgba(188, 170, 164, 0.2)", stroke: "rgba(161, 136, 127, 1)" },
    { fill: "rgba(189, 189, 189, 0.2)", stroke: "rgba(117, 117, 117, 1)" },
    { fill: "rgba(24, 255, 255, 0.2)", stroke: "rgba(0, 229, 255, 1)" }
  ];

  return function(index, options) {
    var color = (FILL_COLORS[index] || FILL_COLORS[0]);

    return {
      label: options.label,
      data: options.data,
      fillColor: color.fill,
      strokeColor: color.stroke,
      pointColor: color.stroke,
      pointStrokeColor: "#fff",
      pointHighlightFill: "#fff",
      pointHighlightStroke: "rgba(220,220,220,1)"
    }
  }
});
