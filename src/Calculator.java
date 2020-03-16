import java.awt.BorderLayout;
import java.awt.Container;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
 
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JTextField;
 
public class Calculator extends JPanel implements ActionListener {
	private static final long serialVersionUID = 5L;
	
private JTextField display = new JTextField("0");
  private double result = 0;
  private String operator = "=";
  private boolean calculating = true;
 
  public Calculator() {
    setLayout(new BorderLayout());
 
    display.setEditable(false);
    add(display, "North");
 
    JPanel panel = new JPanel();
    panel.setLayout(new GridLayout(4, 4));
 
    String buttonLabels = "789/456*123-0.=+";
    for (int i = 0; i < buttonLabels.length(); i++) {
      JButton b = new JButton(buttonLabels.substring(i, i + 1));
      panel.add(b);
      b.addActionListener(this);
    }
    add(panel, "Center");
  }
 
  public void actionPerformed(ActionEvent evt) {
    String cmd = evt.getActionCommand();
    if ('0' <= cmd.charAt(0) && cmd.charAt(0) <= '9' || cmd.equals(".")) {
      if (calculating)
        display.setText(cmd);
      else
        display.setText(display.getText() + cmd);
      calculating = false;
    } else {
      if (calculating) {
        if (cmd.equals("-")) {
          display.setText(cmd);
          calculating = false;
        } else
          operator = cmd;
      } else {
        double x = Double.parseDouble(display.getText());
        calculate(x);
        operator = cmd;
        calculating = true;
      }
    }
  }
 
  private void calculate(double n) {
    if (operator.equals("+"))
      result += n;
    else if (operator.equals("-"))
      result -= n;
    else if (operator.equals("*"))
      result *= n;
    else if (operator.equals("/"))
      result /= n;
    else if (operator.equals("="))
      result = n;
    display.setText("" + result);
  }
 
  @SuppressWarnings("deprecation")
public static void calc() {
    JFrame.setDefaultLookAndFeelDecorated(true);
    JFrame frame = new JFrame();
    frame.setTitle("Calculator");
    frame.setSize(200, 200);
    frame.addWindowListener(new WindowAdapter() {
      public void windowClosing(WindowEvent e) {
      }
    });
 
    Container contentPane = frame.getContentPane();
    contentPane.add(new Calculator());
    frame.show();
  }
}