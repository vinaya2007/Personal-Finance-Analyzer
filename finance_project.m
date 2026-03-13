function finance_project(income, rent, food, travel, other)

% Calculate expenses and savings
total_expenses = rent + food + travel + other;
savings = income - total_expenses;

% -----------------------------
% Generate Financial Suggestions
% -----------------------------

suggestions = "";

if savings < income * 0.2
    suggestions = strcat(suggestions, "Your savings are low. Try saving at least 20 percent of your income.\n");
end

if rent > income * 0.3
    suggestions = strcat(suggestions, "Your rent is high. Consider reducing housing expenses if possible.\n");
end

if food > income * 0.2
    suggestions = strcat(suggestions, "Food spending is slightly high. Meal planning can help reduce costs.\n");
end

if travel > income * 0.15
    suggestions = strcat(suggestions, "Travel expenses are high. Try using public transport or carpooling.\n");
end

if other > income * 0.1
    suggestions = strcat(suggestions, "Other expenses are high. Track unnecessary purchases.\n");
end

% If savings are strong
if savings >= income * 0.3
    suggestions = strcat(suggestions, "Great job maintaining strong savings.\n");
    suggestions = strcat(suggestions, "Consider investing part of your savings for future growth.\n");
end

% Ensure at least 2 suggestions
lines = strsplit(suggestions, "\n");

if length(lines) <= 2
    suggestions = strcat(suggestions, "Try following the 50-30-20 budgeting rule for better financial balance.\n");
end

% Save suggestions to file for Flask
fid = fopen("static/suggestions.txt","w");
fprintf(fid,"%s",suggestions);
fclose(fid);

% -----------------------------
% Pie Chart (Expense Distribution)
% -----------------------------

categories = [rent food travel other savings];
labels = {'Rent','Food','Travel','Other','Savings'};

figure('visible','off');
pie(categories, labels);
title('Monthly Expense Distribution');
saveas(gcf,'static/pie_chart.png');

% -----------------------------
% Savings Growth Graph
% -----------------------------

months = 1:6;
growth = savings * months;

figure('visible','off');
plot(months, growth, '-o');
xlabel('Months');
ylabel('Total Savings');
title('Savings Growth Over 6 Months');
grid on;
saveas(gcf,'static/savings_graph.png');

% -----------------------------
% Expense Comparison Bar Chart
% -----------------------------

expenses = [rent food travel other];

figure('visible','off');
bar(expenses);
set(gca,'XTickLabel',{'Rent','Food','Travel','Other'});
title('Expense Comparison');
grid on;
saveas(gcf,'static/expense_bar.png');

% Close figures
close all;

end