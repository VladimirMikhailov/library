define("library/graphs_spec", ["library/graphs"], function(Graphs) {
  describe("library/graphs", function() {
    describe("when data was preloaded", function() {
      beforeEach(function() {
        Library.data = { graphs: {one: 1, two: 2} }
      });

      it("responds to attributes", function() {
        expect(new Graphs().one).toEqual(1);
      });

      it("responds to attributes", function() {
        expect(new Graphs().one).toEqual(1);
      });
    });

    describe("when called not listed preloaded attribute", function() {
      beforeEach(function() {
        Library.data = { graphs: {one: 1, two: 2} }
      });

      it("responds with undefined", function() {
        expect(new Graphs().authors).toBeUndefined();
      });
    })

    describe("when data was not preloaded", function() {
      beforeEach(function() {
        Library.data = undefined;
      });

      it("responds with undefined", function() {
        expect(new Graphs().one).toBeUndefined();
      });
    })
  });
});
