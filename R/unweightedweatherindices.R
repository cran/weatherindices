
#' Un-weighted Weather Indices
#' @description Converts the weekly weather data into yearly un-weighted weather indices(simply averaged)
#' @param y A vector of yearly yield data for t years
#' @param weatherp Weekly weather data for t years as vector (total observations= number of years*number of weeks in each year)
#'
#'
#' @return A vector of weather indices
#' @export
#' @references Jain, R. C., Agrawal, R., & Jha, M. P. (1980). Effect of climatic variables on      rice yield and its forecast. MAUSAM, 31(4), 591-596.
#' @examples
#' data(Burdwanweather) #Weekly weather data for the rice growing season in Burdwan
#' data(Burdwanriceyield) #Yearly Yield data of rice  in Burdwan
#' wwi.maxtem<-wwi(Burdwanriceyield$burdwan,Burdwanweather$Max.Temperature)
#' wwi.maxtem

uwwi=function(y,weatherp){
  t=1:length(y)
  week=1:(length(weatherp)/length(t))
  wp1=data.frame(matrix(weatherp,nrow=length(y),byrow=T))
  colnames(wp1)=1:length(week)
  detrended.y=(y-(lm(y~t)$fitted))
  cor(wp1[,1],detrended.y)
  rwp1=cor(wp1[,1:length(week)],detrended.y)
  rwp1mat=matrix(rwp1[,1])
  wp1mat=as.matrix(wp1)
  uwwi=as.vector((t(rwp1mat^0)%*%t(wp1mat))/sum(rwp1^0))
  return(uwwi)
}


