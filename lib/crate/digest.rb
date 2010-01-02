require 'digest/md5'
require 'digest/sha1'

module Crate
  #
  # A wrapper around a given digest value and the algorithm that creates it.
  # Use it to verify a bytestream.
  #
  class Digest

    attr_reader :engine
    attr_reader :hex

    class << self
      def sha1( hex )
        return Crate::Digest.new( hex, ::Digest::SHA1 )
      end

      def md5( hex )
        return Crate::Digest.new( hex, ::Digest::MD5  )
      end
    end

    def initialize( hex, klass )
      @hex = hex
      @engine = klass.new
    end

    # 
    # verify that the given filename has a digest value
    #
    def valid?( filename )
      data = File.open(filename, "rb") { |f| f.read }
      engine.hexdigest( data ) == hex
    end
  end
end
