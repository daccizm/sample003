class Picture < ActiveRecord::Base

  scope :filter_upid, lambda{ |upid| where(upid: upid) if upid.present? }

  before_save :set_thumbnail

  mount_uploader :image, ImageUploader

  def store_files zip_file
    return unless zip_file
    path = dir_path
    Zip::File.open( zip_file.tempfile.path ) do |zip|
      zip.each do |entry|
        zip.extract( entry, path + "/" + entry.to_s ) { true }
      end
    end
  end

  private

  def dir_path
    path = "#{Rails.root}/tmp/" + self.user_id.to_s + "_" + self.upid
    Dir::mkdir( path, 0744 ) unless File::exists?( path )
    path
  end

  def set_thumbnail
    path       = dir_path
    filenames  = Dir::entries( path ).select{|file| /^img/ =~ file }
    self.image = File.open( path + "/" + filenames.sort.first )
  end

end
