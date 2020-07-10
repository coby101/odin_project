$trades = []

def stock_picker(history, verbose = false)
  $trades = []
  price_yesterday = 0
  movement = 'none'
  history.each_with_index do |price_today, day|
    if day == 0 then price_yesterday = price_today
    else
      if price_yesterday < price_today then
        $trades.each do |trade|
          unless trade[:income] > price_today then
            trade[:income] = price_today
            trade[:sell_date] = day
          end
        end
        unless movement == 'up' then $trades.push({buy_date: day - 1, cost: price_yesterday, sell_date: day, income: price_today}) end
        movement = 'up'
      elsif movement != 'down' and price_yesterday != price_today then
        $trades.each do |trade|
          unless trade[:income] > price_today then
            trade[:income] = price_today
            trade[:sell_date] = day
          end
        end
        if    price_yesterday < price_today then movement = 'up'
        elsif price_yesterday > price_today then movement = 'down'
        end
      elsif price_yesterday > price_today then movement = 'down'
      end
      price_yesterday = price_today
    end
  end
  # done the scan, pick the best trade
  if $trades.empty? then
    if verbose then puts "Bear market, there are no investment opportunities" end
    []
  else
    $trades.sort! {|a, b| b[:income] - b[:cost] <=> a[:income] - a[:cost]}
    if verbose then puts "The best you can do is buy on day #{$trades.first[:buy_date]} at $#{$trades.first[:cost]}" +
                         " and sell on day #{$trades.first[:sell_date]} at $#{$trades.first[:income]} for a profit of" +
                         " $#{$trades.first[:income] - $trades.first[:cost]}"
    end
    [$trades.first[:buy_date], $trades.first[:sell_date]]
  end
end

tests =
  [[1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
   [10, 9, 8, 7, 6, 5, 4, 3, 2, 1],
   [1, 2, 3, 4, 5, 4, 3, 2, 1],
   [1, 2, 3, 2, 3, 4, 3, 4, 5, 4, 3, 2, 1],
   [2, 3, 4, 5, 4, 3, 2, 1, 2, 3, 4, 5],
   [1, 2, 3, 3, 3, 3, 2, 1],
   [10, 9, 8, 7, 6, 5, 6, 5, 4, 3],
   [17,3,6,9,15,8,6,1,10]]
    
#tests.map {|hist| puts "Test data: #{hist}"; puts stock_picker hist}

        
      
