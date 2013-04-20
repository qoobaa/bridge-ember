@Bridge.BidView = Ember.View.extend
  templateName: "bid"
  tagName: "span"

  content: (->
    switch
      when @get("bid.isPass")     then "Pass"
      when @get("bid.isDouble")   then "Dbl"
      when @get("bid.isReDduble") then "Rdbl"
      when @get("bid.isContract")
        switch @get("bid.trump")
          when "C" then @get("bid.level") + "<span class='suit-c'>♣</span>"
          when "D" then @get("bid.level") + "<span class='suit-d'>♦</span>"
          when "H" then @get("bid.level") + "<span class='suit-h'>♥</span>"
          when "S" then @get("bid.level") + "<span class='suit-s'>♠</span>"
          else
            @get("bid.content")
  ).property("bid.content")
