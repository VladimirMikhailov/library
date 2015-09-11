define("library_spec", ["library"], function(library) {
  describe("library", function() {
    describe("#yearLabels", function() {
      it("returns collection with years from 1940 to 2015", function() {
        expect(library.yearLabels.length).toEqual(
          (library.maxYear - library.minYear) + 1
        );
      });

      it("returns sorted labels", function() {
        var labels = library.yearLabels.slice().sort();

        expect(JSON.stringify(library.yearLabels)).toEqual(
          JSON.stringify(labels)
        );
      });
    });
  });
});
