class DuoApi
  class MessageOnlyException < StandardError
    def backtrace
      []
    end
  end

  class HeaderError < MessageOnlyException; end
  class RateLimitError < MessageOnlyException; end
  class ResponseCodeError < MessageOnlyException; end
  class ContentTypeError < MessageOnlyException; end
  class PaginationError < MessageOnlyException; end

  class ChildAccountError < MessageOnlyException; end
end
