WickedPdf.config ||= {}

WickedPdf.config.merge!(
  exe_path: ENV.fetch("WKHTMLTOPDF_PATH", "C:/Program Files/wkhtmltopdf/bin/wkhtmltopdf.exe")
)
