library(tuneR)

sample_rate <- 12000
modsweep <- list ()
modfreqs <- list ()
for (i in 110:1760) {
    temp <- sine(i,duration=round(sample_rate/100),samp.rate=sample_rate,xunit="samples")
    zeros_up <- which((temp@left[1:(length(temp)-1)] < 0) & (temp@left[2:length(temp)] >= 0))
    modsweep[[i]] <- Wave(left = temp@left[1:zeros_up[length(zeros_up)]],samp.rate=sample_rate,bit=32,pcm=FALSE)
    modfreqs[[i]] <- rep(i,length(modsweep[[i]]@left))
}
modosc <- do.call ("bind", modsweep[110:880])
modoscf <- do.call ("c", modfreqs[110:880])
prinosc <- sine(55,duration=length(modoscf),samp.rate=sample_rate,xunit="samples")
zeros <- which((prinosc@left[1:(length(prinosc)-1)] < 0) != (prinosc@left[2:length(prinosc)] < 0))
synced <- list ()
for (i in 1:(length(zeros)-1)) {
    freq <- modoscf[zeros[i]]
    samp_range <- which(modoscf == freq)
    if (length(samp_range) < zeros[i+1] - zeros[i]) {
       samp_range <- rep(samp_range,round(zeros[i+1] - zeros[i] / length(samp_range))+1)
    }
    length(samp_range) <- zeros[i+1]-zeros[i]
    synced[[i]] <- Wave(left=modosc@left[samp_range],samp.rate=sample_rate,bit=32,pcm=FALSE)
}
syncosc <- do.call ("bind", synced)
play(syncosc, "/usr/bin/afplay")
plot(syncosc@left[1:10000],type="l")
