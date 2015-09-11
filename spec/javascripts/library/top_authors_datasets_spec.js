define(
  "library/top_authors_datasets_spec",
  ["library/top_authors_datasets", "library"],
  function(Dataset, library) {
    describe("library/top_authors_datasets", function() {
      describe("#all", function() {
        describe("when it is no authors' publishments", function() {
          it("returns blank collection", function() {
            expect(new Dataset().all()).toEqual([]);
          });
        });

        describe("when it is any authors' publishments", function() {
          beforeEach(function() {
            Library.data = {
              graphs: {
                top_authors_publishments: [{name: "Alexander Pushkin", publishments: {1950: 1}}]
              }
            };

            this.dataset = new Dataset().all();
            this.data = this.dataset[0].data
          });

          it("returns dataset of authors collection", function() {
            expect(this.dataset.length).toEqual(1)
          });

          it("fills zeros if no publishment for a year", function() {
            var data = this.data.splice(1950 - library.minYear + 1, 1).sort();

            expect(data[0]).toEqual(0);
            expect(data[data.length - 1]).toEqual(0);
          });

          it("fills publishment years with actual data", function() {
            expect(this.data[1950 - library.minYear]).toEqual(1);
          });
        });
      });
    });
  }
);
