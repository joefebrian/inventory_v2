class ReportDocument
  def initialize(data = nil)
    @data = data if data
    @headers = []
    @body = []
  end

  def headers=(head)
    @headers = head
  end

  def output(format = :html)
    case format
    when :html
      html_generator
    else
      
    end
  end

  def html_generator
    var = 'xxx'
    result = <<html
      <table>
        <tr>
          <th>Test</th>
        </tr>
        <tr>
          <td>#{var}</td>
        </tr>
      </table>
html
    result
  end
end
