function [pl] = pltdb(f,p,r,cl)
  
  if isequal(r,'ps')
    pl = plot( f/1e3,10*log10(p/(20e-6^2)),'Color',cl);
    ylabel( 'power[dB SPL]' );
    xlabel( 'frequency[kHz]' );
  elseif isequal(r,'psd')
    pl = plot( f/1e3,10*log10(p),'Color',cl);
    xlabel('frequency[kHz]')
    ylabel('power/frequency [dB/Hz]')
  end

  xlim([ f(1)/1e3 f(end)/1e3 ]);
  ylim([-250 150]);

  ax = gca;
  ax.FontSize = 17;

end
