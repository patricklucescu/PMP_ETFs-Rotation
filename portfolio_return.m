function log_return = portfolio_return( Data, tickers, w, start_date, end_date)
    start_index = find( Data.("Dates") == start_date);
    end_index = find( Data.("Dates") == end_date);

    if start_index > end_index
        error("Please input an end date bigger than the start date")
    end
    prices = [] ;%retrieve prices for selected tickers
    for i = tickers
        prices = [prices Data.(i)];
    end
    
    w = repelem(w,end_index-start_index-1,1); %adjust weights for each trading day
    for k = start_index:end_index-1
        price_day = prices(k,:);
        for i = 1:length(price_day)
            if price_day(i) == 0
                w(k,i) = 0;
            end
        end
        total_w = sum( w(k,:));
        w(k,:) = w(k,:) / total_w;
    end
        
    ordinary_return = zeros(end_index-start_index,1);
    for i = 1:length(tickers)
        time_return = zeros(end_index-start_index,1);
        stock_price = prices(:,i); %extract prices for given stock
        for j = start_index:end_index-1 
            dayly_return = stock_price(j+1)/stock_price(j)-1;
            time_return(j) = time_return(j) + dayly_return;
        end
        ordinary_return = ordinary_return + time_return .* w(i); % check this is correct
    end
    
    log_return = log(ordinary_return+ones(end_index-start_index,1));
end
            
            
    
    

    

 
        