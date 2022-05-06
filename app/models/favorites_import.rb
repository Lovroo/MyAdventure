class FavoritesImport
  include ActiveModel::Model
  require 'roo'

  attr_accessor :file

  def initialize(attributes={})
    attributes.each { |name, value| send("#{name}=", value) }
  end

  def persisted?
    false
  end

  def open_spreadsheet
    case File.extname(file.original_filename)
    when ".csv" then Csv.new(file.path, nil, :ignore)
    when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  def load_imported_favorites
    spreadsheet = open_spreadsheet
    header = spreadsheet.row(5)
    (6..spreadsheet.last_row).map do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      favorite = FavDestination.find_by_id(row["id"]) || FavDestination.new
      favorite.attributes = row.to_hash
      favorite
    end
  end

  def imported_favorites
    @imported_favorites||= load_imported_favorites
  end

  def save
    if imported_favorites.map(&:valid?).all?
      imported_favorites.each(&:save!)
      true
    else
      imported_favorites.each_with_index do |favorite, index|
        favorite.errors.full_messages.each do |msg|
          errors.add :base, "Row #{index + 6}: #{msg}"
        end
      end
      false
    end
  end

end