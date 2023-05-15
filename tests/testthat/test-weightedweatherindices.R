
test_that("wwi provides a yearly weighted weather indices", {
  wwi.precipitation<-wwi(Burdwanriceyield$burdwan,Burdwanweather$Precipitation)
  t=1:length(Burdwanriceyield$burdwan)
  week=1:(length(Burdwanweather$Precipitation)/length(t))
  wp1=data.frame(matrix(Burdwanweather$Precipitation,nrow=length(Burdwanriceyield$burdwan),byrow=T))
  colnames(wp1)=1:length(week)
  detrended.y=(Burdwanriceyield$burdwan-(lm(Burdwanriceyield$burdwan~t)$fitted))
  cor(wp1[,1],detrended.y)
  rwp1=cor(wp1[,1:length(week)],detrended.y)
  rwp1mat=matrix(rwp1[,1])
  wp1mat=as.matrix(wp1)
  wwi=as.vector((t(rwp1mat)%*%t(wp1mat))/sum(rwp1))
  expect_equal(wwi.precipitation,wwi)
})


test_that("wwi provides a weather indices for each year", {
  wwi.precipitation<-wwi(Burdwanriceyield$burdwan,Burdwanweather$Precipitation)
  expect_equal(length(wwi.precipitation),length(Burdwanriceyield$burdwan))
})

test_that("wwi provides a numeric vector of weather indices", {
  wwi.precipitation<-wwi(Burdwanriceyield$burdwan,Burdwanweather$Precipitation)
  expect_type(wwi.precipitation,"double")
  is.numeric(wwi.precipitation)
})
