
test_that("uwwi provides a yearly unweighted weather indices", {
  uwwi.precipitation<-uwwi(Burdwanriceyield$burdwan,Burdwanweather$Precipitation)
  t=1:length(Burdwanriceyield$burdwan)
  week=1:(length(Burdwanweather$Precipitation)/length(t))
  wp1=data.frame(matrix(Burdwanweather$Precipitation,nrow=length(Burdwanriceyield$burdwan),byrow=T))
  colnames(wp1)=1:length(week)
  detrended.y=(Burdwanriceyield$burdwan-(lm(Burdwanriceyield$burdwan~t)$fitted))
  cor(wp1[,1],detrended.y)
  rwp1=cor(wp1[,1:length(week)],detrended.y)
  rwp1mat=matrix(rwp1[,1])
  wp1mat=as.matrix(wp1)
  uwwi=as.vector((t(rwp1mat^0)%*%t(wp1mat))/sum(rwp1^0))
  expect_equal(uwwi.precipitation,uwwi)
})


test_that("uwwi provides a weather indices for each year", {
  uwwi.precipitation<-uwwi(Burdwanriceyield$burdwan,Burdwanweather$Precipitation)
  expect_equal(length(uwwi.precipitation),length(Burdwanriceyield$burdwan))
})

test_that("uwwi provides a numeric vector of weather indices", {
  uwwi.precipitation<-uwwi(Burdwanriceyield$burdwan,Burdwanweather$Precipitation)
  expect_type(uwwi.precipitation,"double")
  is.numeric(uwwi.precipitation)
})
