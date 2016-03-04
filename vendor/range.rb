class RangeFilter
  def initialize(app)
    @app = app
  end

  def call(env)
    dup._call(env)
  end

  def _call(env)
    @status, @headers, @response = @app.call(env)
    range = env['HTTP_RANGE']

    if @status == 200 && range && /\Abytes=(\d*)-(\d*)\z/ =~ range
      @first_byte = $1
      @last_byte = $2

      @data = ''.encode('BINARY')
      @response.each do |s|
        @data << s
      end
      if @length.nil?
        @length = @data.bytesize
      end

      if @last_byte.empty?
        @last_byte = @length - 1
      else
        @last_byte = @last_byte.to_i
      end

      if @first_byte.empty?
        @first_byte = @length - @last_byte
        @last_byte = @length - 1
      else
        @first_byte = @first_byte.to_i
      end

      @range_length = @last_byte - @first_byte + 1
      @headers['Content-Range'] = "bytes #{@first_byte}-#{@last_byte}/#{@length}"
      @headers['Content-Length'] = @range_length.to_s
      [@status, @headers, self]
    else
      [@status, @headers, @response]
    end
  end

  def each(&block)
    block.call(@data[@first_byte..@last_byte])
    @response.close if @response.respond_to?(:close)
  end
end
