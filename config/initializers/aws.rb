# config/initializers/aws.rb

attachment_config = {
  s3_credentials: {
    access_key_id:     Rails.application.secrets.aws_access_key_id,
    secret_access_key: Rails.application.secrets.aws_secret_access_key,
    bucket:            Rails.application.secrets.s3_bucket_name
  },

  storage:        :s3,
  s3_headers:     { 'Cache-Control' => 'max-age=31557600' },
  s3_protocol:    'https',
  url:            ':s3_alias_url',
  bucket:         Rails.application.secrets.s3_bucket_name,

  styles: {
    mini:     '48x48>',
    small:    '100x100>',
    product:  '240x240>',
    large:    '600x600>'
  },

  path:          '/products/:id/:style/:basename.:extension',
  default_url:   'noimage/:style.png',
  default_style: 'product'
}

attachment_config.each do |key, value|
   Spree::Image.attachment_definitions[:attachment][key.to_sym] = value
end unless Rails.env.test?

# workaround for `NameError (uninitialized constant Aws::VERSION)`
Aws::VERSION =  Gem.loaded_specs["aws-sdk"].version