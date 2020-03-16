import java.awt.EventQueue;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import javax.swing.JLabel;
import java.awt.Font;
import javax.swing.SwingConstants;
import javax.swing.JButton;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;

public class Shutdown extends JFrame {

	/**
	 * 
	 */
	private static final long serialVersionUID = 4L;
	private JPanel contentPane;

	/**
	 * Launch the application.
	 */
	public static void shutdown() {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					Shutdown frame = new Shutdown();
					frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	/**
	 * Create the frame.
	 */
	public Shutdown() {
//		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 285, 150);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(null);
		
		JLabel lblThisWillShut = new JLabel("This will shut down your computer.");
		lblThisWillShut.setHorizontalAlignment(SwingConstants.CENTER);
		lblThisWillShut.setFont(new Font("Segoe UI", Font.PLAIN, 15));
		lblThisWillShut.setBounds(12, 13, 243, 32);
		contentPane.add(lblThisWillShut);
		
		JButton btnShutDown = new JButton("Shut Down");
		btnShutDown.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try {
					 Runtime.getRuntime().exec(new String[] {"cmd", "/c", "shutdown /s"});
				 }
				 catch(Exception e1) {
					 System.out.println("Program failed to run.");
					 e1.printStackTrace();
				 }
			}
		});
		btnShutDown.setBounds(82, 65, 97, 25);
		contentPane.add(btnShutDown);
	}
}
