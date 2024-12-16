class Blog < ApplicationRecord
  belongs_to :user, optional: true
  has_many :likes

  has_one_attached :image
  has_one_attached :video
  has_many_attached :images

  # picture image uploader
  mount_uploader :image, ImageUploader

  # movie video uploder
  mount_uploader :video, VideoUploader

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      blog = find_by(id: row["id"]) || new
      blog.attributes = row.to_hash.slice(*csv_attributes)
      blog.save!
    end
  end

  def self.csv_attributes
    %w(days title body status switch)
  end

  def self.generate_csv
    CSV.generate(headers: true) do |csv|
      csv << csv_attributes
      Blog.includes(@blogs).all.each do |blog|
        csv << csv_attributes.map { |attr| blog.send(attr) }
      end
    end
  end

  # seach method
  def self.search(search)
    return Blog.preload(@blogs).all unless search
    blogs = Blog.arel_table
    Blog.where(blogs[:body].matches("%#{search}%"))
  end

  scope :full_text_search, -> (query) {
    where("body @@ ?", query)
  }
end
