class RenameAudioToMp3 < ActiveRecord::Migration
  def change
    rename_column :songs, :audio_file_name, :mp3_file_name
    rename_column :songs, :audio_content_type, :mp3_content_type
    rename_column :songs, :audio_file_size, :mp3_file_size
    rename_column :songs, :audio_updated_at, :mp3_updated_at
  end
end
