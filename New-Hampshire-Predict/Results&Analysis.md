The goal of this project was simplistic: to answer the question as to if previous candidate performance could predict current
candidate performance in the New Hampshire primary.  The analysis set out to understand if the primary each 4 years in NH is in fact
unique from previous races or whether a conventional wisdom follows the primary outcome.

To analyze this, I collected data for previous candidate performances.  This presented a unique challenge in the fact that election from
2008 forward have had significantly more polling - or at least polling results - still available to the public.  It was easy to obtain 
the information on the individual candidates for both the 2008 and 2012 election cycles by collecting the data from the RealClearPolitics
averages.

However, for the years 2000 and 2004, this information was not compiled by RealClearPolitics and no compilation of multiple polls was 
compiled.  In fact, it became difficult to even find polls for 2004, but especially 2000.  It became increasingly difficult to find 
polling for the individual states of Iowa and New Hampshire.  For these years, I used national Gallup polls as well as polls conducted by
Gallup for New Hampshire.  The values used for polling in Iowa were collected from the final polls of the Des Moines Register, which has
been considered the "gold standard" by pollsters.

Running multiple linear regression, it became clear that there was a distinct difference between the regressions of Republican and 
Democratic candidates, which should not be all too surprising.  If the parties differ on political ideology, why should they not differ on how or why they select which candidate to support in a primary?

Therefore, Republicans and Democrats were separated out into their own regressions in order to analyze the results and better predict
the outcome of the New Hampshire primary.  The regressions for Republicans and Democrats are similar, but contain slight differences.

For Democrats, only two variables showed any signs of statistical significance: NH Predicted Polling and the change in the candidate's 
national polls from the time of Iowa caucus to the time of the New Hampshire primary.

![Image of Democrat Regression] (https://github.com/ScottOnestak/Data-Analysis-Projects/blob/master/New-Hampshire-Predict/DemReg.png)

What was interesting was that an increase in the national polls resulted in a decrease in NH performance.  An increase in the national
polls after Iowa is usually driven by candiates that do well in the state.  This is usually attributed to two factors: winning Iowa
and overperforming expectations.  And while these individual factors did show some signs of a relationship with performance in NH, they were far from a statistically significant relations.  That is why the change in national polls was a better representation of 
the overall sentiment after Iowa because it works as a proxy to understand both of those factors and more in order to determine people's opinion on the candidates in the race after the first showing.

What was also interesting was the negative relationship between the change in national polls and New Hampshire performance.  This leads me to believe that there is a large difference in the electorates of Iowa and New Hampshire.  Therefore, candidates who 
perform well in Iowa tend to perform less well in New Hampshire.  And while -.77% support in NH for every 1% gain nationally might 
not be that large of a coefficient on the surface, crowded fields - such as that on the GOP side this year - may be significantly impacted by this when the margins between the candidates are close.

On the GOP side, two factors seemed to be in play: NH primary polling results and a candidate's national polling average.  This
national polling average has a negative correlation with the outcome in NH, which leads me to believe that the NH electorate is not
your typical Republican electorate.  There are many reasons why that might be.  First is that there is a libertarian streak in NH.  
The second is that NH is seen as a more moderate state than the typical Republican voter.  And third is that New Hampshire is an open
primary, so independents might heavily influence the results as opposed to the closed caucus of Iowa.

![Image of Republican Regression] (https://github.com/ScottOnestak/Data-Analysis-Projects/blob/master/New-Hampshire-Predict/RepReg.png)

So, what were the results?

In order to predict and then analyze the results, I used two different sets of polling averages.  The first were the RealClearPolitics
polling averages of the candidates, in which equal weight is given to the polls used in the average.  The second were the polling
averages from Nate Silver's FiveThirtyEight, which has established a weighting model for the polls based on the pollster's rating as
well as the sample size of the poll.

Here are the predictions and results for the Democrats.

| Candidate | RCP Forecast | 538 Forecast | Actual Results | RCP Error | 538 Error |
| :-------: | :----------: | :----------: | :------------: | :-------: | :-------: |
| Bernie Sanders | 55.93% | 55.71% | 60.40% | -4.47% | -4.69% |
| Hillary Clinton | 43.49% | 42.03% | 37.95% | +5.54% | +4.08% |

Here are the predictions and results for the Republicans.

| Candidate | RCP Forecast | 538 Forecast | Actual Results | RCP Error | 538 Error |
| :-------: | :----------: | :----------: | :------------: | :-------: | :-------: |
| Donald Trump | 32.08% | 30.19% | 35.34% | -3.26% | -5.15% |
| John Kasich | 15.28% | 15.20% | 15.81% | -0.53% | -0.61% |
| Marco Rubio | 14.11% | 14.90% | 10.57% | +3.54% | +4.33% |
| Jeb Bush | 13.08% | 12.83% | 11.02% | +2.06% | +1.81% |
| Ted Cruz | 10.93% | 10.94% | 11.68% | -0.75% | -0.74% |
| Chris Christie | 6.07% | 6.71% | 7.42% | -1.35% | -0.71% |
| Carly Fiorina | 5.19% | 5.31% | 4.12% | +1.07% | +1.19% |
| Ben Carson | 1.81% | 2.33% | 2.29% | -0.48% | +0.04% |

So, while the results show there is clearly some error in predicting the correct outcome in terms of final percent support.  There are
a few important take aways from the model.

1) The model more accurately predicts the results than simply the polls alone.

While the model could not accurately predict the correct results for all the candidates, it did predict much closer than just polling 
averages alone.  In fact, the model better predicted the outcome of the Clinton-Sanders race than polls alone.  In addition, the model
got the order of GOP contenders better than the polls.  For the polls, the top 5 would have looked like Trump, Rubio, Kasich, Cruz, and Bush - placing only Trump in the correct spot.  However, the model predicts the order Trump, Kasich, Rubio, Bush, Cruz - 
correctly predicting all but Cruz and Rubio.  And delegate wise Cruz, Bush, and Rubio all tied because the vote count was so close between the three, so in that sense, the model could be considered correct.

2) The model was not able to predict results based on other events.

The important factor with this is that the model was unable to correctly incorporate significant events into its prediction.  This is
best exemplified through Marco Rubio.  The media believed he had a poor debate three days before the primary, which resulted in bad 
press.  As a result, the debate performance as well as the negative publicity was not able to be taken into account for polling at both the state and national level, which made his results difficult to gauge for the model.

3) The extremely small sample size may play an important element, and with more data points going forward, the model may improve.

The Republican data contained only 18 data points, and the Democrat data contained a mere 12.  With that being said, the small sample
size was still able to outperform a polls-only analysis.  Going forward, more data points may make the model more accurate and a 
better predictor for future New Hampshire primaries.

3) The model's results show importance, but should be taken with a grain of salt.

The results show that initial question as to whether each election cycle is unique or follow conventional wisdom show characteristics
of both.  The model's results showed that conventional wisdom prevailed in a sense that the model was better to predict the outcome 
than polling alone.  Therefore, there is a convential wisdom that these other factors are significant and in play when trying to
predict the results of the New Hampshire primary.

With that being said, every election cycle is unique in the sense that there are events that are unable to be accounted for - such as a poor debate performance, bad press, weather, accidents, etc.  Therefore, the model should be accepted with a grain of salt, not
set-in-stone fact.  Since the model outperformed a polls-only analysis, my suggestion would be to perform the analysis and then assess
the unique race from there.  Because the model is more accurate, it may lead people through convential wisdom to better results than
applying that conventional wisdom to the polling results.
