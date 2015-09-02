module Library
  describe BulkSave do
    let(:authors) { "Fyodor Dostoyevsky" }

    subject(:export_authors) { described_class.new(table: :authors).save(authors) }

    describe "#save" do
      context "with valid CSV format" do
        let(:authors) { "Fyodor Dostoyevsky\nAlexander Pushkin" }

        it "saves the list to table" do
          expect { export_authors }.to change { Author.count }.to(2)
        end
      end

      context "with nil returned" do
        let(:authors) { nil }

        it "doesn't change the number of authors" do
          expect { export_authors }.not_to change { Author.count }
        end
      end

      context "with bigger number of input columns" do
        let(:authors) { "Fyodor Dostoyevsky,Alexander Pushkin" }

        it "raises bad copy format error" do
          expect { export_authors }.to raise_error(PG::BadCopyFileFormat)
        end
      end

      context "when table doesn't exist" do
        subject(:export_authors) { described_class.new(table: :wrong_table).save(authors) }

        it "raises undefined table error" do
          expect { export_authors }.to raise_error(PG::UndefinedTable)
        end
      end

      context "when column for table doesn't exist" do
        subject(:export_authors) do
          described_class.new(table: :authors, columns: ["wrong"]).save(authors)
        end

        it "raises undefined column error" do
          expect { export_authors }.to raise_error(PG::UndefinedColumn)
        end
      end
    end
  end
end
