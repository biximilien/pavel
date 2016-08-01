module Pavel::Linator

  def copy_files(files, source_path, target_path)
    files.each do |filename|
      # Make directory
      target_filename = filename.gsub(source_path, target_path)

      make_directory_if_not_exist(target_filename)

      copy_file(filename, target_filename)
    end

    # FileUtils.cp(files, target_path, verbose: Pavel.verbose)
  end

  def copy_file(source_filename, target_filename)
    FileUtils.cp(source_filename, target_filename, verbose: Pavel.verbose)
  end

  def make_directory_if_not_exist(filename)
    dirname = File.dirname(filename)
    unless File.directory?(dirname)
      # print "Creating directory: #{dirname}..."
      FileUtils.mkdir_p(dirname, verbose: Pavel.verbose)
      # puts " Done."
    end
  end

  def clean_src_dir
    raise "[DANGER] NOT IMPLEMENTED UNTIL CODE IS ACTUALLY PUSHED ON A REPO"
  end

  def clean_temp_dir
    clean_dir(Pavel.temp[:path])
  end

  def clean_target_dir
    clean_dir(Pavel.target[:path])
  end

  def clean_dir(dirname)
    Dir.glob(dirname + '/*') do |filename|
      FileUtils.rm_rf(filename, verbose: Pavel.verbose)
    end
  end

  def process_html(document)
    # Remove comments
    comment = Pavel::HTML::Comment.new(document)
    comment.remove

    # Remove title
    title = Pavel::HTML::Title.new(document)
    title.remove

    # Remove header
    header = Pavel::HTML::Header.new(document)
    header.remove

    # Remove unnecessary divs
    Pavel::HTML::Div.descendants.each do |descendant|
      element = descendant.new(document)
      element.remove
    end

    # Remove nav
    nav = Pavel::HTML::Nav.new(document)
    nav.remove

    # Remove footer
    footer = Pavel::HTML::Footer.new(document)
    footer.remove

    # Remove archived from h1
    h1 = Pavel::HTML::H1.new(document)
    h1.remove

    # Remove gov't domain from links
    a = Pavel::HTML::A.new(document)
    a.remove_domains

    # Remove modification date
    dl = Pavel::HTML::DL.new(document)
    dl.remove
  end

  def get_html_document(filename, encoding)
    document = nil

    File.open filename, "r:#{encoding}" do |file|
      document = Nokogiri::HTML(file, nil, encoding)
    end

    return document
  end

  def write_html_document(document, filename, encoding)
    File.open filename, "w:#{encoding}" do |file|
      file.write(document.to_html)
    end
  end

  def traverse(queue, visited, root)
    visited.push root
    document = Nokogiri::HTML(open(root))
    puts "Traversing #{root}..."
    traverse_document(queue, visited, document)

    while queue.length > 0
      filename = queue.pop
      visited.push(filename) if !visited.include?(filename)

      if File.extname(filename) =~ /\.(?:html|htm)$/i
        document = Nokogiri::HTML(open(filename))
        puts "Traversing #{filename}..."
        traverse_document(queue, visited, document)
      end
    end
  end

  def traverse_document(queue, visited, document)
    document.css(Pavel.resources_tags).each do |resource|
      case resource.name
      when 'a', 'link'
        next if href_invalid?(resource)
        filename = "#{Pavel.temp[:path]}/#{URI.parse(resource.attribute('href').to_s).path}"
        queue.push(filename) if file_valid?(filename) && !visited.include?(filename) && !queue.include?(filename)
      when 'script', 'img'
        next if src_invalid?(resource)
        filename = "#{Pavel.temp[:path]}/#{URI.parse(resource.attribute('src').to_s).path}"
        queue.push(filename) if file_valid?(filename) && !visited.include?(filename) && !queue.include?(filename)
      end
    end
  end

  private

    def src_invalid?(img_or_script_tag)
      img_or_script_tag.attribute('src').nil? || img_or_script_tag.attribute('src').to_s.empty?
    end

    def href_invalid?(a_or_link_tag)
      a_or_link_tag.attribute('href').nil? || a_or_link_tag.attribute('href').to_s.empty?
    end

    def file_valid?(filename)
      File.exist?(filename) && !File.directory?(filename)
    end

end