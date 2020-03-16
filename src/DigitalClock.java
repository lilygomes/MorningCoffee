/* import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class timeFetch {
	public static Date date = Calendar.getInstance().getTime();  
	public static DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd kk:mm:ss");  
	public static String strDate = dateFormat.format(date);
	
}
*/

import java.awt.Font;
import java.awt.Color;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.Timer;
import javax.swing.SwingConstants;
import java.util.*;
import java.text.*;
 
public class DigitalClock {
 
  public static void clock() {
 
    ClockLabel dateLable = new ClockLabel("date");
    ClockLabel timeLable = new ClockLabel("time");
    ClockLabel dayLable = new ClockLabel("day");
 
    JFrame.setDefaultLookAndFeelDecorated(true);
    JFrame f = new JFrame("Digital Clock");
    f.setSize(300,150);
//    f.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    f.setLayout(new GridLayout(3, 1));
 
    f.add(dateLable);
    f.add(timeLable);
    f.add(dayLable);
 
    f.getContentPane().setBackground(Color.black);
 
    f.setVisible(true);
  }
}
 
class ClockLabel extends JLabel implements ActionListener {
 
  /**
	 * 
	 */
	private static final long serialVersionUID = 6L;
String type;
  SimpleDateFormat sdf;
 
  public ClockLabel(String type) {
    this.type = type;
    setForeground(Color.white);
 
    switch (type) {
      case "date" : sdf = new SimpleDateFormat("  MMMM dd yyyy");
                    setFont(new Font("sans-serif", Font.PLAIN, 12));
                    setHorizontalAlignment(SwingConstants.LEFT);
                    break;
      case "time" : sdf = new SimpleDateFormat("kk:mm:ss");
                    setFont(new Font("sans-serif", Font.PLAIN, 40));
                    setHorizontalAlignment(SwingConstants.CENTER);
                    break;
      case "day"  : sdf = new SimpleDateFormat("MM/dd/yyyy kk:mm:ss");
      				setFont(new Font("Yu Gothic UI", Font.PLAIN, 16));
      				setHorizontalAlignment(SwingConstants.RIGHT);
      				break;
      default     : sdf = new SimpleDateFormat("MM/dd/yyyy kk:mm:ss");
      				setFont(new Font("Yu Gothic UI", Font.PLAIN, 16));
      				setHorizontalAlignment(SwingConstants.RIGHT);
                    break;
    }
 
    Timer t = new Timer(100, this);
    t.start();
  }
 
  public void actionPerformed(ActionEvent ae) {
    Date d = new Date();
    setText(sdf.format(d));
  }
}
