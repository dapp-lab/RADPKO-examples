library(tidyverse)
library(gganimate)

## load RADPKO data
radpko <- read_csv('radpko_bases.csv')

## create time-series animation
ts_gg <- radpko %>%
  group_by(mission, date) %>% ## group by mission-date
  summarize(personnel = sum(pko_deployed)) %>% # get total personnel deployed
  ggplot(aes(x = date, y = personnel, color = mission)) + # setup ggplot
  geom_line() + # lines
  scale_color_discrete(name = 'Mission') + # legend title
  labs(x = 'Date', y = 'Personnel') + # axis labels
  ggtitle('Peacekeepers Deployed') + # title
  theme_bw() + # simple theme
  theme(panel.grid = element_blank(), # remove grid
        panel.border = element_blank()) + # remove border
  transition_reveal(date) # animation

## animate time-series at 5 FPS
anim <- animate(ts_gg, fps = 5)

## save gif
anim_save('personnel_timeseries.gif', animation = anim)
