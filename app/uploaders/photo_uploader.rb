class PhotoUploader < CarrierWave::Uploader::Base
  # Добавляем обработчик, чтобы можно было менять размер фотографий
  # и делать миниатюрные версии
  include CarrierWave::RMagick

  # Изображения будут храниться локально в специальной папке проекта
  storage :file

  # Папка, в которой будут храниться все наши загруженные файлы
  # Например, uploads/photo/photo/1
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Фотографию надо обрезать и уменьшить так, чтобы получился квадрат 800x800
  process resize_to_fit: [800, 800]

  # А потом нужно сделать миниатюрную версию 100x100
  version :thumb do
    process resize_to_fit: [100, 100]
  end

  # Мы разрешаем для загрузки только картинки
  def extension_white_list
    %w[jpg jpeg gif png]
  end
end
