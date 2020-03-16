import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import javax.swing.JButton;
import javax.swing.JLabel;
import java.awt.Font;
import javax.swing.SwingConstants;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;

public class exit extends JFrame {

	private static final long serialVersionUID = 7L;
	private JPanel contentPane;

	/**
	 * Launch the application.
	 */
	public static void exitPrompt() {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					exit frame = new exit();
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
	public exit() {
//		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 285, 150);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(null);
		
		JButton btnExit = new JButton("Exit");
		btnExit.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				System.exit(1);
			}
			});
		btnExit.setBounds(82, 65, 97, 25);
		contentPane.add(btnExit);
		
		JLabel lblThisWillExit = new JLabel("This will exit MorningCoffee.");
		lblThisWillExit.setHorizontalAlignment(SwingConstants.CENTER);
		lblThisWillExit.setFont(new Font("Segoe UI", Font.PLAIN, 15));
		lblThisWillExit.setBounds(12, 13, 243, 32);
		contentPane.add(lblThisWillExit);
	}
}
