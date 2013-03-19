# encoding: utf-8
class MyApp
  RESP = {
     '/' => lambda {root},
    '/memory' => lambda {memory},
    '/disk' => lambda {disk},
    '/help' => lambda {help}
  }

  def call(env)
    req = Rack::Request.new(env)
    @res = Rack::Response.new
    @res.status = 200
    @res['content-type'] = 'text/html;charset=utf-8'
    @res.body = [ body(req.env['REQUEST_PATH']) ]
    @res.finish
  end

   def self.help
    "<ul>
      <li>GET / - инфо о памяти и размере диска</li>
      <li>GET /memory - инфо о памяти</li>
      <li>GET /disc - инфо о размере диска</li>
      <li>GET /help - эта страница</li>
    </ul>"
  end

  def self.disk
    %x(df -h)
  end

  def self.memory
    %x(free -m)
  end

  def self.root
    "<ul>
      <li>#{memory}</li>
      <li>#{disk}</li>
    </ul>"
  end

  def body url
    if RESP[url]
      body_text = '<p>' + RESP[url].call + '</p>'
    else
      body_text = '<h2>404</h2>'
      @res.status = 404
    end
    body_text
  end
end